---
tags:
  - guide
  - mba
---

# AI Workflow Guide

> Cách sử dụng AI (Cursor, Claude, Codex) hiệu quả trong vault MBA.

---

## Nguyên tắc cốt lõi

1. **AI không làm việc trực tiếp trong `05_Submit/`** - phải qua review trước
2. **Context rõ ràng = output tốt hơn** - luôn chuẩn bị context trước khi hỏi AI
3. **AI output → `03_WIP/` hoặc `07_AI-Workspace/Outputs/`** - sau đó review rồi mới promote
4. **Tag `#ai/needs-review`** cho mọi output chưa kiểm tra

---

## Cấu trúc AI Workspace trong mỗi môn

```
07_AI-Workspace/
├── Context/        → Thông tin giúp AI hiểu bối cảnh
├── Prompts/        → Prompt templates tái sử dụng
└── Outputs/        → Kết quả từ AI chờ review
```

### Context/ chứa gì?

| File | Nội dung |
|------|----------|
| `course-context.md` | Tóm tắt môn, objectives, rubric, style |
| Assignment-specific context | Brief + constraints cho từng bài |

### Prompts/ chứa gì?

Prompt templates chuẩn hóa:
- Tóm tắt bài giảng
- Phân tích case study
- Review bài viết theo rubric
- Giải thích concept
- Tạo flashcards
- Dịch + localize

### Outputs/ chứa gì?

- Draft từ AI chưa review (`#ai/needs-review`)
- Analysis results
- Summaries

---

## Workflow cho từng scenario

### Scenario 1: Tóm tắt bài giảng

```
1. Nghe giảng, ghi note thô → 02_Lectures/
2. Paste note vào AI với prompt từ Prompts/
3. AI output → 03_WIP/ hoặc append vào lecture note
4. Review, chỉnh sửa → update note chính
```

### Scenario 2: Viết tiểu luận

```
1. Đề bài → 04_Deliverables/<tên>/00_Brief/
2. Tạo context cho AI: rubric + constraints → 07_AI-Workspace/Context/
3. Dàn ý (tự viết hoặc AI hỗ trợ) → 01_Outline/
4. AI draft sections → 03_WIP/  (#ai/needs-review)
5. Review + edit → 02_Draft/
6. Polish → 04_Review/
7. Final check → 05_Submit/
8. Nhận điểm → 06_Feedback/
```

### Scenario 3: Phân tích case study

```
1. Case data → 03_References/ hoặc 99_Attachments/
2. Yêu cầu AI phân tích theo framework → Outputs/
3. Review + bổ sung insight cá nhân → 02_Draft/
4. Finalize → 05_Submit/
```

### Scenario 4: Ôn thi

```
1. Tổng hợp notes quan trọng
2. AI tạo flashcards → 06_Exam-Prep/
3. AI tạo mock questions → 06_Exam-Prep/
4. Tự test + review
```

---

## Quy tắc an toàn với AI

| Rule | Lý do |
|------|-------|
| Không paste toàn bộ đề thi vào AI | Academic integrity |
| Luôn review output trước submit | AI có thể sai |
| Ghi rõ phần nào AI hỗ trợ | Minh bạch |
| Không để AI output thẳng vào Submit | Cần human review |
| Backup context quan trọng | AI session có thể mất |

---

## Prompt Engineering Tips

### Structure tốt cho prompt:

```
[Role]: Bạn là chuyên gia về [lĩnh vực]
[Context]: Đây là môn [tên môn], giảng viên yêu cầu [...]
[Task]: Hãy [hành động cụ thể]
[Constraints]: 
  - Viết bằng [ngôn ngữ]
  - Dài khoảng [X] từ
  - Theo format [APA/Harvard]
  - Focus vào [điểm chính]
[Output format]: Trả lời dưới dạng [bullet/table/essay/...]
```

### Context loading cho Cursor:

Khi làm việc trong Cursor, mở file `07_AI-Workspace/Context/course-context.md` để AI tự động có context. Hoặc dùng `@file` reference:

```
@07_AI-Workspace/Context/course-context.md
Dựa vào context trên, hãy [yêu cầu]
```

---

## Tag workflow

```
Tạo note mới → #stage/inbox
AI generate  → #ai/needs-review + #stage/wip
Đã review    → #ai/final-checked + #stage/draft
Sẵn sàng nộp → #stage/submit
```

---
**Navigation**: [[00_Dashboard/Home|Home]]
