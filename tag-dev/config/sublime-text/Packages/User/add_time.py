from typing import List, Optional
from datetime import datetime, timedelta
from functools import partial
from itertools import islice
import collections

import sublime
import sublime_plugin


def attr_content_region(view: sublime.View, tag_region: sublime.Region, attr: str) -> Optional[sublime.Region]:
    attr_region = view.find(attr + '="', tag_region.begin())
    if not tag_region.contains(attr_region): return None
    string_region = view.expand_to_scope(attr_region.end() + 1, "string")
    if string_region is None: return None
    return sublime.Region(string_region.begin() + 1, string_region.end() - 1)


def is_event_tag(view: sublime.View, tag_region) -> bool:
    return view.substr(tag_region).startswith("<event ")


def event_tags(view: sublime.View) -> List[sublime.Region]:
    return list(filter(partial(is_event_tag, view), view.find_by_selector("meta.tag.xml")))


def parse_delta(delta: str) -> timedelta:
    if delta.endswith('d'):
        return timedelta(hours=8)
    if delta.endswith('h'):
        return timedelta(hours=int(delta[:-1]))
    elif ":" in delta:
        hours, minutes = delta.split(":")
        return timedelta(hours=int(hours), minutes=int(minutes))
    else:
        raise ValueError("Invalid time delta")


def sliding_window(iterable, n):
    # sliding_window('ABCDEFG', 4) --> ABCD BCDE CDEF DEFG
    it = iter(iterable)
    window = collections.deque(islice(it, n), maxlen=n)
    if len(window) == n:
        yield tuple(window)
    for x in it:
        window.append(x)
        yield tuple(window)


class AddTimeCommand(sublime_plugin.TextCommand):
    def run(self, edit):
        for sel in reversed(self.view.sel()):
            tag_region = self.view.expand_to_scope(sel.b, "meta.tag.xml")
            if tag_region is None: continue
            tag_str = self.view.substr(tag_region)

            start_string_content_region = attr_content_region(self.view, tag_region, "start")
            if start_string_content_region is None: continue

            start_str = self.view.substr(start_string_content_region).rstrip('Z').replace(' ', '')
            start_time = datetime.fromisoformat(start_str)

            end_string_content_region = attr_content_region(self.view, tag_region, "end")
            if end_string_content_region is None: continue

            delta = parse_delta(self.view.substr(end_string_content_region))
            end_time = start_time + delta
            end_str = end_time.isoformat(timespec='seconds') + "Z"

            self.view.replace(edit, end_string_content_region, end_str)


class FixEventidCommand(sublime_plugin.TextCommand):
    def run(self, edit):

        for i, tag_region in reversed(list(enumerate(event_tags(self.view)))):
            event_region = attr_content_region(self.view, tag_region, "eventid")
            if event_region is None:
                print("Event attribute not found!")
                continue

            self.view.replace(edit, event_region, str(i + 1))


TIME_OVERLAP_KEY = "timeoverlap"
DOCUMENT_LINK_FLAGS = sublime.HIDE_ON_MINIMAP | sublime.DRAW_NO_FILL | sublime.DRAW_NO_OUTLINE | sublime.DRAW_SOLID_UNDERLINE  # noqa: E501

class CheckTimeOverlapCommand(sublime_plugin.TextCommand):
    def run(self, edit):
        self.view.erase_regions(TIME_OVERLAP_KEY)

        overlaps: List[sublime.Region] = []

        for first, second in sliding_window(event_tags(self.view), 2):
            end_string_content_region = attr_content_region(self.view, first, "end")
            if end_string_content_region is None: continue

            try:
                end_str = self.view.substr(end_string_content_region).rstrip('Z')
                end_time = datetime.fromisoformat(end_str)
            except ValueError as e:
                start_string_content_region = attr_content_region(self.view, first, "start")
                if start_string_content_region is None: continue

                start_str = self.view.substr(start_string_content_region).rstrip('Z')
                start_time = datetime.fromisoformat(start_str)

                try:
                    delta = parse_delta(self.view.substr(end_string_content_region))
                    end_time = start_time + delta
                except Exception as e:
                    overlaps.append(self.view.expand_to_scope(end_string_content_region.a, "string") or end_string_content_region)
                    continue

            start_string_content_region = attr_content_region(self.view, second, "start")
            if start_string_content_region is None: continue

            start_str = self.view.substr(start_string_content_region).rstrip('Z')
            start_time = datetime.fromisoformat(start_str)

            if end_time > start_time:
                overlaps.append(start_string_content_region)

        if len(overlaps) == 0:
            sublime.status_message("Good job! No time overlaps found")
        else:
            self.view.add_regions(TIME_OVERLAP_KEY, overlaps,
                scope="markup.underline.link.lsp", flags=DOCUMENT_LINK_FLAGS)
