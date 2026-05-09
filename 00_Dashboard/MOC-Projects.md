---
tags:
  - moc
  - dashboard
  - project
---

# 📋 Projects Overview

---

## 🔄 Active Projects

```dataview
TABLE subject as "Subject", deadline as "Deadline", status as "Status"
FROM "06_Projects"
WHERE status != "done" AND status != "archived"
SORT deadline ASC
```

---

## 👥 Group Projects

```dataview
TABLE subject as "Subject", assignment_type as "Type", deadline as "Deadline"
FROM #assignment
WHERE assignment_type = "group"
SORT deadline ASC
```

---

## 👤 Individual Projects

```dataview
TABLE subject as "Subject", assignment_type as "Type", deadline as "Deadline"
FROM #assignment
WHERE assignment_type = "individual"
SORT deadline ASC
```

---

## ✅ Completed Projects

```dataview
TABLE subject as "Subject", grade as "Grade"
FROM "06_Projects"
WHERE status = "done"
SORT file.mtime DESC
```

---

**Navigation**: [[00_Dashboard/Home|🏠 Home]]
