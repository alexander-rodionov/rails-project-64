# Blog Platform Documentation

| Service    | URL |
|------------|-----|
| Deployment | [Production Environment](https://rails-project-64-d0sk.onrender.com/) |
| Sentry     | [Error Monitoring Dashboard](https://app.glitchtip.com/personal-use/issues?project=10780) (requires autorization)|

## Overview
This is a Ruby on Rails blog platform with user authentication, posts, comments, and likes functionality.

The application uses Devise for authentication and includes features like nested comments, post likes, and error monitoring.

## Models

### User (`user.rb`)
- Authentication via Devise (email/password)
- Relationships:
  - `has_many :posts` (authored posts)
  - `has_many :post_comments` (comments made)
  - `has_many :post_likes` (likes given)

### Post (`post.rb`)
- Belongs to a category and user (as creator)
- Includes:
  - Validations for title (5-255 chars) and body (200-4000 chars)
  - Scopes for latest posts
  - Methods for likes count, time since creation, and creator email
  - Nested comments functionality

### Category (`category.rb`)
- Simple model that categorizes posts
- `has_many :posts`

### PostComment (`post_comment.rb`)
- Supports nested comments via `ancestry` gem
- Validates content length (5-400 chars)
- Scopes for root comments and recent comments

### PostLike (`post_like.rb`)
- Join table between users and posts for likes
- Simple belongs_to relationships

## Controllers

### PostsController (`posts_controller.rb`)
- Actions: index, show, new, create
- Features:
  - Authentication required for creating posts
  - Latest posts ordering
  - Post creation with validations
  - Comment form setup

### CommentsController (`comments_controller.rb`)
- Handles comment creation (including nested comments)
- Validates and displays error messages

### LikesController (`likes_controller.rb`)
- Provides toggle, create, and destroy actions for post likes
- Uses authentication and maintains like state

### MonitorController (`monitor_controller.rb`)
- Testing endpoints:
  - `exception_check`: Raises test exception
  - `sentry_check`: Tests Sentry integration

## Key Features

1. **User Authentication**
   - Sign up/in/out
   - Password recovery
   - Remember me functionality

2. **Posts System**
   - Rich text content (200-4000 characters)
   - Category organization
   - Creator attribution

3. **Comments**
   - Nested/threaded comments
   - Content validation
   - User attribution

4. **Likes**
   - Simple toggle functionality
   - Like/unlike actions
   - Current user tracking

5. **Error Monitoring**
   - Sentry integration
   - Exception testing endpoint

## Setup Instructions

1. Install dependencies:
   ```bash
   bundle install
   yarn install
   ```

2. Set up database:

    ```bash
    rails db:create
    rails db:migrate
    ```

3. Configure environment variables:
    - Set Sentry DSN for error monitoring
    - Configure Devise mailer settings

4. Start the server:
    ```bash
    rails server
    ```
## Testing

Run the test suite with:
```bash
rails test
```

Key test cases:
- User authentication
- Post creation and validation
- Comment nesting
- Like toggling
- Error handling

## Deployment

The application includes:

- Asset precompilation
- Database setup
- Test automation in deployment script

## Error Handling

The system includes:
- Custom error pages
- Sentry integration
- Controller-level exception handling
- Monitor endpoints for testing

## Dependencies

- Ruby on Rails
- Devise (authentication)
- Ancestry (nested comments)
- Sentry (error monitoring)
- Bootstrap (frontend framework)