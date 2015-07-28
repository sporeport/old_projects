JournalApp.Routers.PostsRouter = Backbone.Router.extend({

  initialize: function (options) {

    this.$rootEl = options.$rootEl;
    this.posts = new JournalApp.Collections.Posts();
  },

  routes: {
    "": "postsIndex",
    "posts/new": "postNew",
    "posts/:id": "postsShow",
    "posts/:id/edit": "postEdit"

  },

  postsIndex: function () {
    this.posts.fetch({ reset: true });
    var indexView =
      new JournalApp.Views.PostsIndex({ collection: this.posts });
    this.$rootEl.find('.sidebar').html(indexView.$el);
  },

  postEdit: function (id) {
    var post = this.posts.getOrFetch(id);
    var postFormView = new JournalApp.Views.PostForm({ model: post});
    this._swapView(postFormView);
  },

  postNew: function () {
    var post = new JournalApp.Models.Post();
    var postFormView = new JournalApp.Views.PostForm({ model: post, collection: this.posts });
    this._swapView(postFormView);
  },

  postsShow: function (id) {
    var post = this.posts.getOrFetch(id);
    var showView = new JournalApp.Views.PostsShow({ model: post });
    this.$rootEl.find('.content').html(showView.$el);
  },

  _swapView: function (newView) {
    this._currentView && this._currentView.remove();
    this._currentView = newView;
    this.$rootEl.html(newView.$el);
    newView.render();
  }

})
