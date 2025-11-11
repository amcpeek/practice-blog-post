# Blog Application - Project Plan

## Data Models

**Posts (Blogs)**
- `title` (string)
- `body` (text)
- `published_at` (datetime, nullable - null = unpublished)
- `author_id` (references users table)

**Users**
- `first_name` (string)
- `last_name` (string)
- `email` (string, unique)

**Comments**
- `body` (text)
- `author_id` (references users table)
- `post_id` (references posts table)
- `created_at`, `updated_at` (automatic)

## Relationships

- **Posts**: `belongs_to :user` (as author), `has_many :comments`
- **Users**: `has_many :posts`, `has_many :comments`
- **Comments**: `belongs_to :post`, `belongs_to :user` (as author)
- Posts → Comments: 1:many
- Users → Posts: 1:many
- Users → Comments: 1:many

## Authentication & Authorization

- Email-only (no password for now, add later if time)
- **With email**: Can create, edit, delete their own content
- **Without email**: Can view only published posts
- **Unpublished posts**: Only visible to author

## Functionality

- Full CRUD on Posts
- Full CRUD on Comments
- View all published posts (public)
- View own unpublished posts (author only)
- View comments on each post

## Implementation Steps

1. ✅ Rollback Post migration
2. ✅ Generate User model (first_name, last_name, email)
3. ✅ Re-generate Post model with correct fields
4. ✅ Generate Comment model
5. ✅ Run all migrations
6. Set up model associations
7. Create controllers (Posts, Comments, Sessions/Auth)
8. Create views with Tailwind
9. Implement authorization logic
10. Test full CRUD flows
