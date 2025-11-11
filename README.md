# Riverside High School Blog

A Ruby on Rails blog application built for Riverside High School, allowing faculty and students to share posts, comment, and engage with school content.

## Features

### Current Features
- **User Authentication**: Email-only authentication system (no passwords required)
- **Posts Management**: Full CRUD functionality for blog posts
  - Create, read, update, and delete posts
  - Draft system (unpublished posts only visible to author)
  - Rich post content with title and body
- **Comments**: Users can comment on published posts
  - Only comment authors can delete their own comments
- **Categories**: Posts can be tagged with multiple categories
  - Sports, Arts & Culture, Events, Academics, Community
  - Filter posts by category
- **Filtering & Sorting**:
  - Filter by category
  - Filter by author
  - Sort by date (newest/oldest first)
- **Authorization**:
  - Only post authors can edit or delete their posts
  - Only comment authors can delete their comments
  - Unpublished posts are only visible to the author

## Tech Stack

- **Ruby on Rails** 8.1.1
- **Ruby** 3.4.7
- **SQLite3** database
- **Tailwind CSS** v4 for styling
- **Turbo Rails** for SPA-like navigation
- **Propshaft** for asset pipeline

## Setup

1. Clone the repository
2. Install dependencies:
   ```bash
   bundle install
   npm install
   ```
3. Set up the database:
   ```bash
   rails db:migrate
   rails db:seed
   ```
4. Start the development server:
   ```bash
   bin/dev
   ```
5. Visit http://localhost:3000

## Database Structure

### Models
- **User**: Represents faculty and students
  - `first_name`, `last_name`, `email` (unique)
- **Post**: Blog posts created by users
  - `title`, `body`, `published_at` (nullable for drafts)
  - `belongs_to :author` (User)
  - `has_many :categories` through join table
- **Comment**: Comments on posts
  - `body`
  - `belongs_to :post`
  - `belongs_to :author` (User)
- **Category**: Categorization for posts
  - `name` (unique)
  - Sports, Arts & Culture, Events, Academics, Community

## Next Steps

### 1. Admin Permissions & Principal Authentication
- Add role-based authorization (admin, faculty, student)
- Implement password authentication for the principal
- Grant principal/admin ability to:
  - Edit or delete any post
  - Moderate comments
  - Manage users
  - Create and manage categories

### 2. Enhanced Styling & CSS
- Develop a cohesive color scheme (purple theme for school colors)
- Add custom styles for:
  - Category badges with distinct colors
  - Post cards with better visual hierarchy
  - Form improvements
  - Responsive design for mobile devices
- Add school logo/branding
- Improve typography and spacing

### 3. Testing
- Write unit tests for models (validations, associations, methods)
- Write controller tests for authorization logic
- Write integration tests for:
  - User authentication flow
  - Post creation and publishing
  - Comment functionality
  - Filtering and sorting
- Add system tests for critical user journeys

### 4. Additional Features (Future)
- User profiles with avatars
- Post search functionality
- Email notifications for new comments
- Rich text editor for post body
- Image uploads for posts
- "Like" or "React" functionality
- RSS feed for published posts
- Archive/unpublish posts (soft delete)

## Development

Run linter:
```bash
bundle exec rubocop -a
```

Rebuild CSS:
```bash
rails tailwindcss:build
```

Run tests:
```bash
rails test:all
```

## License

This project is built for educational purposes.
