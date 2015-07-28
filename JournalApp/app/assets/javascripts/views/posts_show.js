JournalApp.Views.PostsShow = Backbone.View.extend({
  initialize: function () {
    this.listenTo(this.model, "sync", this.render);
  },

  urlRoot: '/posts',
  template: JST['posts/show'],

  render: function() {
    this.$el.html(this.template({ post: this.model }));
    return this;
  }


});
