NewsReader.Views.FeedShow = Backbone.View.extend({
  template: JST['feeds/show'],

  initialize: function(options) {
    this.listenTo(this.model, "sync", this.render);
  },

  render: function () {
    this.$el.html(this.template({ feed: this.model }));
    return this;
  }
})
