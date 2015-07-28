JournalApp.Views.PostsIndexItem = Backbone.View.extend({
  template: JST['posts/index_item'],
  tagName: 'li',
  events: {
    "click .post-delete-button": "deletePost"
  },

  deletePost: function (event) {
    this.model.destroy();
  },

  render: function () {
    this.$el.html(this.template( {post: this.model} ));
    return this;
  }
})
