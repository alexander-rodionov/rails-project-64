# Blog Platform Documentation

| Service    | URL |
|------------|-----|
| Deployment | [Production Environment](https://rails-project-64-d0sk.onrender.com/) |
| Sentry     | [Error Monitoring Dashboard](https://app.glitchtip.com/personal-use/issues?project=10780) (requires autorization)|


## Overview
This is a Ruby on Rails blog platform that allows users to create posts, comment on them, and like posts. The platform includes user authentication to ensure secure access and interaction.


## Key Features
1. **User Authentication**
* Sign up, sign in, and sign out functionality.
* "Remember me" options.

2. **Posts System**
* Create and view posts.
* Organize posts by categories.
* Attribute posts to their creators.

3. **Comments**
* Add nested/threaded comments to posts.
* Validate comment content.
* Attribute comments to users.

4. **Likes**
* Toggle like/unlike actions on posts.
* Track likes by the current user.

5. **Error Monitoring**
* Integration with Sentry for error tracking.
* Custom error pages and exception handling.

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

## Deployment

The application includes:

- Asset precompilation
- Database setup
- Test automation in deployment script

## Usage
* **Create a Post**: Authenticated users can create new posts with a title and body.
* **Comment on a Post**: Users can add comments to posts, including nested replies.
* **Like a Post**: Users can like or unlike posts with a simple toggle.