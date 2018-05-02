//= require cable
//= require_self
//= require_tree .

this.App = {};
App.cable = ActionCable.createConsumer();

App.messages = App.cable.subscriptions.create('SiteChannel', {
    received: function(data) {
        if (data.status === 'active') {
            var css_class = 'success';
        }else if (data.status === 'inactive') {
            var css_class = 'danger';
        }else{
            var css_class = 'default';
        }
        $('.site-status-' + data.site).removeClass('default success danger').addClass(css_class)
    }
});