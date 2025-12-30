# Rails Blog Bootcamp 📝

A modern Rails blog application built step-by-step with Posts, Users, Comments, and advanced query optimization. This is a learning project demonstrating Rails best practices.

![Rails](https://img.shields.io/badge/Rails-8.1-CC0000?style=flat-square&logo=ruby-on-rails)
![Ruby](https://img.shields.io/badge/Ruby-3.3+-CC0000?style=flat-square&logo=ruby)
![SQLite](https://img.shields.io/badge/SQLite-3-003B57?style=flat-square&logo=sqlite)
![License](https://img.shields.io/badge/License-MIT-green?style=flat-square)

---

## 🎥 Demo

## 🎥 Demo

<video width="700" controls>
  <source src="rubySreenVd.mp4" type="video/mp4">
</video>

---

## 🎯 Features

### Core Blog Functionality

- ✅ **Posts Management** - Create, read, update, delete posts
- ✅ **User Association** - Each post belongs to a user
- ✅ **Comments System** - Nested comments on posts with user association
- ✅ **URL Slugs** - SEO-friendly post URLs with unique slugs per user
- ✅ **Validations** - Title, body, and comment length validations
- ✅ **Publishing Status** - Draft and published post states

### Queries & Performance 🚀

- ✅ **Smart Scopes** - Composable query scopes for filtering
  - `published` - Show published posts only
  - `drafts` - Show draft posts only
  - `recent` - Order by newest first
  - `by_author(user_id)` - Filter by author
  - `search(query)` - Full-text search in title and body
- ✅ **Filter UI** - Advanced filtering interface
- ✅ **N+1 Query Prevention** - Eager loading with includes
- ✅ **Counter Cache** - Automatic comment count tracking
- ✅ **Composable Filters** - All filters work together safely

---

## 📦 Requirements

- Ruby 3.3+
- Rails 8.1+
- SQLite 3
- Node.js 18+

---

## 🚀 Installation & Setup

### 1. Clone the repository

```bash
git clone https://github.com/ManaR-Rch/Ruby_blog_CRUD.git
cd blog_bootcamp
```

### 2. Install dependencies

```bash
bundle install
yarn install
```

### 3. Setup the database

```bash
bin/rails db:create
bin/rails db:migrate
```

### 4. Start the server

```bash
bin/dev
```

Visit `http://localhost:3000` in your browser.

---

## 🏗️ Architecture

### Models

- **User**: has_many posts and comments
- **Post**: belongs_to user, has_many comments with scopes
- **Comment**: belongs_to post and user with counter_cache

---

## 🔍 Advanced Features

### Smart Scopes

- `Post.published` - Published posts only
- `Post.drafts` - Draft posts only
- `Post.recent` - Order by newest first
- `Post.by_author(id)` - Filter by author
- `Post.search(query)` - Full-text search

### Performance Improvements

- **N+1 Prevention**: Eager loading with includes
- **Counter Cache**: Automatic comment counts stored in DB
- **Composable Queries**: All filters work together

---

## 📄 API Endpoints

**Posts**: GET/POST /posts, GET/PATCH/DELETE /posts/:id  
**Comments**: POST/DELETE /posts/:post_id/comments/:id

---

## 📊 Performance Impact

**Before Optimization**: ~100+ queries for 50 posts  
**After Optimization**: 1 query for 50 posts

---

## 🧪 Testing

```bash
bin/rails test
```

---

## 📝 Development Progress

- ✅ Post CRUD operations
- ✅ Users, Comments, and Slugs
- ✅ Scopes, Filters, and Performance optimization

---

**Built with ❤️ during Rails Bootcamp**
