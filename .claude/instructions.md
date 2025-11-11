# Claude Code - Best Practices for Annika's Rails Coding Challenge

## Process Before Coding

### 1. ALWAYS Plan First
Before writing any code:
- Present a clear, step-by-step plan
- Estimate tokens/time this will take (small: <5 min, medium: 5-15 min, large: 15+ min)
- Wait for explicit approval before proceeding
- Break large tasks into smaller chunks

Example:
```
Plan:
1. Generate Post model with title, body, published_at
2. Add controller with index, show, new, create actions
3. Create views with Tailwind styling
4. Add routes

Estimated time: ~8 minutes (medium task)
Token usage: ~15,000 tokens

Does this approach work for you?
```

### 2. Rails + Tailwind Best Practices

#### Avoid N+1 Queries
- Use `includes()` or `eager_load()` for associations
- Example: `@posts = Post.includes(:user, :comments).all`
- Check with `rails console` if unsure

#### Database Best Practices
- Add indexes on foreign keys (usually automatic with `references`)
- Add indexes on frequently queried columns
- Use appropriate column types (text vs string, integer vs bigint)

#### Controller Best Practices
- Keep controllers thin, move logic to models or service objects
- Always use strong parameters
- Use `before_action` for common setup (like finding records)
- Handle both HTML and Turbo Stream responses when using Turbo

#### View Best Practices
- Use partials to keep views DRY
- Avoid logic in views - use helper methods or decorators
- Use `turbo_frame_tag` for page sections that update independently

#### Tailwind Best Practices
- Use utility classes, avoid custom CSS when possible
- Use `@apply` in stylesheets only when absolutely necessary
- Common patterns: `flex items-center justify-between`, `space-y-4`, `max-w-4xl mx-auto`
- For forms: Consistent spacing and clear visual hierarchy

#### Security
- Never trust user input - always sanitize
- Use strong parameters in controllers
- Be careful with `html_safe` - prefer `sanitize` helper
- CSRF protection is on by default, don't disable it

### 3. Work Within 90-Minute Constraint

#### Time Management Priorities
1. **Core functionality first** - Get basic CRUD working
2. **Then add polish** - Styling, validations, edge cases
3. **Skip perfection** - Good enough > perfect but incomplete

#### Quick Wins
- Use scaffolding for rapid prototyping if appropriate
- Leverage generators (`rails g model`, `rails g controller`)
- Use Tailwind UI patterns instead of custom styling from scratch
- Copy-paste form patterns rather than rebuilding each time

#### What to Skip/Simplify
- Extensive test coverage (unless required)
- Complex authentication (use simple patterns unless specified)
- Over-engineering (YAGNI - You Aren't Gonna Need It)
- Perfect responsive design (focus on desktop first if time-limited)

### 4. Challenge Instructions That Don't Make Sense

If Annika's instructions:
- Conflict with existing code structure
- Would introduce bugs or security issues
- Seem to misunderstand the current state
- Would take significantly more time than expected
- Go against Rails conventions without good reason

**STOP and say:**
> "I notice [specific issue]. This approach might cause [problem].
> Did you mean [alternative]? Or should we discuss the best path forward?"

### 5. Ask Clarifying Questions

#### When to Ask (ALWAYS prefer asking over guessing):
- Ambiguous requirements ("add user features" - which features?)
- Multiple valid approaches (REST API vs. Turbo Streams?)
- Styling preferences (color scheme, layout structure)
- Data model decisions (what fields should this have?)
- Business logic (what should happen when...?)

#### How to Ask:
- Be specific about what's unclear
- Offer 2-3 options if possible
- Explain trade-offs briefly
- Example: "Should comments be nested under posts (RESTful) or separate? Nested is cleaner URLs but slightly more complex routing."

## Anti-Patterns to Avoid

### ❌ DON'T:
- Put business logic in views or controllers
- Use `find` without error handling in controllers
- Forget to add indexes on foreign keys
- Skip validations on models
- Use `delete` instead of `destroy` (skips callbacks)
- Hardcode values that should be configurable
- Ignore N+1 warnings in development logs
- Use `where.first` when you mean `find_by`

### ✅ DO:
- Use `find_by` for single records, `where` for collections
- Use `destroy` to respect callbacks and associations
- Add `dependent: :destroy` or `dependent: :nullify` on associations
- Validate presence, uniqueness, format at model level
- Use database constraints for critical validations
- Keep views focused on presentation
- Use helpers for view logic

## Quick Decision Framework

When making implementation choices:

1. **Does it work?** (Functionality first)
2. **Is it secure?** (No SQL injection, XSS, etc.)
3. **Is it maintainable?** (Will Annika understand this in 3 months?)
4. **Is it efficient?** (No major N+1 or performance issues)
5. **Does it fit the time budget?** (Can complete in 90 min)

If yes to all 5 → Proceed
If no to 1-2 → Fix immediately
If no to 3-4 → Mention trade-off, ask if acceptable
If no to 5 → Suggest scope reduction

## Remember

- **Speed matters** in a timed challenge
- **Working code beats perfect code** that's incomplete
- **Ask when uncertain** - Annika prefers clarification over wrong assumptions
- **Plan, estimate, confirm** before every significant task
- **Keep calm** - Annika's got this! 🚀
