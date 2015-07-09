NewsReader.Models.User = Backbone.Model.extend({
  urlRoot: "/api/users",

  logged_in: function () {
    !!this.get("session_token")
  }
  // session: function () {
  //   if(!this._session){
  //     this._session = new NewsReader.Models.Session( {user: this} );
  //   }
  //
  //   return this._session;
  // }
})
