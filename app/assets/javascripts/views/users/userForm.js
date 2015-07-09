NewsReader.Views.UserForm = Backbone.View.extend({
  template: JST["users/userForm"],

  events: {
    "submit form":"signUpOrLogIn"
  },

  render: function () {
    var newUser = new NewsReader.Models.User();
    this.$el.html(this.template({ user: newUser }));

    return this;
  },

  signUpOrLogIn: function (event) {
    event.preventDefault();

    var userParams = $(event.currentTarget).serializeJSON();
    var user = new NewsReader.Models.User(userParams["user"]);
    user.fetch({
      error: function () {
        user.save(userParams);
      }
    });
  }
})
