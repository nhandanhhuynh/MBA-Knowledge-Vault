---
tags:
  - moc
  - book-note
---

# 📚 Reading List & Book Notes

---

## Currently Reading

```dataview
TABLE author as "Author", rating as "Rating", related_subjects as "Related To"
FROM #book-note
WHERE status = "reading"
SORT file.mtime DESC
```

## Completed

```dataview
TABLE author as "Author", rating as "Rating", related_subjects as "Related To"
FROM #book-note
WHERE status = "done"
SORT rating DESC
```

---

## Recommended Reading by Subject Area

### Strategy
- [ ] *Good Strategy Bad Strategy* - Richard Rumelt
- [ ] *Blue Ocean Strategy* - W. Chan Kim
- [ ] *Competitive Strategy* - Michael Porter

### Marketing
- [ ] *Marketing Management* - Philip Kotler
- [ ] *Positioning* - Al Ries & Jack Trout
- [ ] *Building Strong Brands* - David Aaker

### Finance
- [ ] *Corporate Finance* - Berk & DeMarzo
- [ ] *The Intelligent Investor* - Benjamin Graham
- [ ] *Financial Intelligence* - Karen Berman

### Leadership
- [ ] *Good to Great* - Jim Collins
- [ ] *The 7 Habits* - Stephen Covey
- [ ] *Leaders Eat Last* - Simon Sinek

### General Business
- [ ] *The Lean Startup* - Eric Ries
- [ ] *Zero to One* - Peter Thiel
- [ ] *Thinking, Fast and Slow* - Daniel Kahneman

---
**Navigation**: [[00_Dashboard/Home|🏠 Home]]
