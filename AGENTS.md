# MBA LLM Wiki Schema

This vault uses a three-layer model adapted from Karpathy's LLM Wiki pattern.

## 1. Raw sources

These are source-of-truth materials. Read them, but do not overwrite them unless the user explicitly asks.

- `01_Courses/*/01_Admin/`
- `01_Courses/*/02_Lectures/`
- `01_Courses/*/03_References/`
- `01_Courses/*/04_Deliverables/`
- `01_Courses/*/05_Group-Work/`
- `01_Courses/*/06_Exam-Prep/`
- `01_Courses/*/99_Attachments/`
- `02_Thesis/`
- `03_Resources/`

`07_AI-Workspace/Outputs/` is temporary working output, not the durable wiki.

## 2. Wiki layer

Each active course may contain `08_Wiki/`, which is the durable LLM-maintained knowledge layer.

Recommended structure:

```text
08_Wiki/
├── index.md
├── log.md
├── 01_Concepts/
├── 02_Frameworks/
├── 03_Entities/
├── 04_Syntheses/
└── 05_Questions/
```

Page roles:

- `01_Concepts/`: one page per concept, theory, term, or mechanism.
- `02_Frameworks/`: models, matrices, methods, and step-by-step analytical tools.
- `03_Entities/`: companies, markets, authors, countries, cases, or stakeholders.
- `04_Syntheses/`: comparisons, thematic summaries, lecture synthesis, exam themes.
- `05_Questions/`: unresolved questions, contradictions, gaps, and follow-up prompts.

## 3. Linking rules

When creating or updating wiki pages:

1. Link every page upward to its course home and `08_Wiki/index.md`.
2. Link every page sideways to at least 2 related pages when they exist.
3. Link claims downward to raw source notes when possible.
4. Prefer concept/entity pages over duplicate summaries.
5. If a topic spans multiple courses, link to a shared resource page in `03_Resources/` instead of duplicating full explanations everywhere.

## 4. Ingest workflow

When the user asks to ingest a new source:

1. Read the raw source.
2. Summarize it in the most relevant existing wiki pages.
3. Create new wiki pages only if the concept/entity deserves reuse.
4. Update `08_Wiki/index.md`.
5. Append one entry to `08_Wiki/log.md`.
6. Add explicit cross-links between the touched pages.

## 5. Query workflow

When answering course questions:

1. Read `00_Course-Home.md`.
2. Read `08_Wiki/index.md` if present.
3. Open the most relevant wiki pages first.
4. Fall back to raw notes only to verify or enrich.
5. If the answer creates durable insight, file it into `08_Wiki/04_Syntheses/`.

## 6. Lint workflow

Periodically check for:

- orphan wiki pages
- duplicate concept pages
- concept pages without source links
- stale syntheses after new lecture/reference ingestion
- unresolved contradictions that should live in `05_Questions/`

