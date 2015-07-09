NewsReader.Collections.Entries = Backbone.Collection.extend({
  url: function() {
    return this.feed.rootUrl + '/entries';
  }
})
