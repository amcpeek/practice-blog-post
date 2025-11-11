# Instructions for Annika - Rails Coding Challenge Cheat Sheet

## Models & Migrations

### Generate Model
```bash
rails g model Post title:string body:text published:boolean user:references
rails db:migrate
```

### Generate Migration
```bash
rails g migration AddColumnToTable column_name:string
rails g migration RemoveColumnFromTable column_name:string
rails db:migrate
```

### Rollback Migration
```bash
rails db:rollback
rails db:rollback STEP=3
```

### Database Commands
```bash
rails db:create          # Create database
rails db:migrate         # Run migrations
rails db:seed           # Run seeds
rails db:reset          # Drop, create, migrate, seed
```

## Controllers & Routes

### Generate Controller
```bash
rails g controller Posts index show new create edit update destroy
```

### RESTful Routes in config/routes.rb
```ruby
resources :posts
resources :posts, only: [:index, :show, :new, :create]
root "posts#index"
```

## Tailwind CSS

### Classes to Remember
```html
<!-- Containers -->
<div class="container mx-auto px-4">
<div class="max-w-4xl mx-auto">

<!-- Flexbox -->
<div class="flex items-center justify-between">
<div class="flex flex-col gap-4">

<!-- Spacing -->
class="mt-4 mb-8 px-6 py-3"
class="space-y-4"  <!-- vertical spacing between children -->

<!-- Buttons -->
<button class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded">

<!-- Forms -->
<input class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700">
```

### Rebuild Tailwind
```bash
rails tailwindcss:watch    # Watch for changes
rails tailwindcss:build    # Build once
```

## Turbo

### Turbo Frame (for partial page updates)
```erb
<%= turbo_frame_tag "post_#{@post.id}" do %>
  <!-- content here -->
<% end %>
```

### Turbo Stream (for multiple updates)
```ruby
# In controller
respond_to do |format|
  format.turbo_stream
  format.html { redirect_to @post }
end
```

```erb
<!-- app/views/posts/create.turbo_stream.erb -->
<%= turbo_stream.prepend "posts", @post %>
<%= turbo_stream.update "form", "" %>
```

### Disable Turbo on Links/Forms
```erb
<%= link_to "Delete", @post, data: { turbo: false } %>
<%= form_with model: @post, data: { turbo: false } %>
```

## Important Reminders

### Strong Parameters in Controller
```ruby
private

def post_params
  params.require(:post).permit(:title, :body, :published)
end
```

### Form Helpers
```erb
<%= form_with model: @post do |f| %>
  <%= f.label :title %>
  <%= f.text_field :title, class: "form-input" %>

  <%= f.label :body %>
  <%= f.text_area :body, rows: 10 %>

  <%= f.check_box :published %>
  <%= f.label :published %>

  <%= f.submit class: "btn btn-primary" %>
<% end %>
```

### Associations
```ruby
# In models
class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
end

class User < ApplicationRecord
  has_many :posts
end
```

### Validations
```ruby
validates :title, presence: true, length: { minimum: 5 }
validates :email, presence: true, uniqueness: true
```

## Server & Console

```bash
rails server          # or rails s
rails console         # or rails c
rails routes          # See all routes
rails routes | grep posts  # Filter routes
```

## Quick Debugging

```ruby
# In controllers/views
puts "DEBUG: #{variable.inspect}"
logger.debug "Value: #{@post.inspect}"

# In console
Post.last
Post.where(published: true)
Post.find_by(title: "Something")
```

## Common Gotchas

1. **Don't forget to restart server** after changing routes or initializers
2. **Strong params** - always permit the params you need
3. **Turbo breaks some JS** - use `data: { turbo: false }` if needed
4. **References in migrations** automatically adds foreign key + index
5. **`form_with` has Turbo enabled by default** in Rails 7

## Time Savers

```bash
# Generate scaffold (quick CRUD)
rails g scaffold Post title:string body:text

# Destroy generators
rails destroy model Post
rails destroy controller Posts

# Run tests
rails test
```

Good luck! 🚀
