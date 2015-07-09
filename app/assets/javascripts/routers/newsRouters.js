NewsReader.Routers.NewsRouter = Backbone.Router.extend({
  initialize: function (options) {
    this.$rootEl = options.$rootEl
    this.feeds = new NewsReader.Collections.Feeds();
  },

  routes: {
    "": "feedsIndex"
  },

  feedsIndex: function () {
    var feedIndex = new NewsReader.Views.FeedIndex({ collection: this.feeds });
    this.$rootEl.html(feedIndex.render().$el)
    this.feeds.fetch()
  }

})
