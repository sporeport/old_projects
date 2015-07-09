NewsReader.Views.FeedShow = Backbone.View.extend({
  template: JST['feeds/show'],

  events: {
    "click button.refresh":"refreshFeed"
  },

  initialize: function(options) {
    this.listenTo(this.model, "sync", this.render);
  },

  render: function () {
    this.$el.html(this.template({ feed: this.model }));
    this.model.entries().each(function(entry){
      var entryView = new NewsReader.Views.EntryShow({model: entry});
      this.$(".entries").append(entryView.render().$el);
    })
    return this;
  },

  refreshFeed: function () {
    this.model.fetch();
  }
})
