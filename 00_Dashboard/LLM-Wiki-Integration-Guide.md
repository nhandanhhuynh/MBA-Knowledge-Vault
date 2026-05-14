---
tags:
  - guide
  - mba
  - ai
  - wiki
---

# LLM Wiki Integration Guide

> Ap dung mo hinh LLM Wiki ma khong pha vo cau truc course-centric hien tai.

## Nguyen tac

Vault hien tai da tot cho quan ly tai lieu hoc tap. Theo Karpathy, ban nen them mot lop trung gian de tri thuc duoc tich luy, lien ket va cap nhat theo thoi gian.

Mo hinh hop ly cho vault nay:

- `01_Admin` / `02_Lectures` / `03_References` / `04_Deliverables`: raw sources
- `07_AI-Workspace`: prompt, context, output tam
- `08_Wiki`: tri thuc ben vung do LLM bao tri

## Vi tri cua `08_Wiki`

Moi mon hoc nen co:

```text
<Course>/
├── 00_Course-Home.md
├── 07_AI-Workspace/
└── 08_Wiki/
    ├── index.md
    ├── log.md
    ├── 01_Concepts/
    ├── 02_Frameworks/
    ├── 03_Entities/
    ├── 04_Syntheses/
    └── 05_Questions/
```

Ly do:

- khong tron raw note voi note tong hop
- AI outputs tam thoi khong lam ban graph
- moi mon co mot "mini wiki" rieng
- sau nay moi de nang cap len wiki lien mon trong `03_Resources/`

## Cach lien ket node

Dung 4 tang lien ket:

1. Hub
- `00_Dashboard/Home` -> course homes
- `00_Course-Home` -> `08_Wiki/index`

2. Category
- `08_Wiki/index` -> concepts / frameworks / entities / syntheses / questions

3. Knowledge
- moi concept page phai link toi framework, entity, va lecture/source lien quan

4. Evidence
- concept/synthesis pages link nguoc lai note goc trong `02_Lectures`, `03_References`, `04_Deliverables`

## Quy uoc link toi uu

Moi note wiki nen co:

- 1 link len `[[00_Course-Home]]`
- 1 link ve `[[08_Wiki/index]]`
- 2-5 link ngang sang page lien quan
- 1-3 link xuong note goc hoac tai lieu goc

Neu mot khai niem lap lai o nhieu mon:

- dat ban giai thich chuan trong `03_Resources/`
- trong tung course chi viet phan "ung dung trong mon nay"
- link 2 chieu giua shared page va course page

## Workflow de LLM de bao tri

Khi them mot lecture hay article moi:

1. luu source vao folder goc phu hop
2. cap nhat hoac tao note trong `08_Wiki/01_Concepts`
3. cap nhat `08_Wiki/04_Syntheses` neu insight co gia tri tong hop
4. them dong moi vao `08_Wiki/log.md`
5. kiem tra page moi co du inbound/outbound links chua

## Navigation

- [[Home]]
- [[Vault-Structure-Guide]]
- [[AI-Workflow-Guide]]

