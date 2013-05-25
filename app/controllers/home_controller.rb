class HomeController < ApplicationController
  before_filter :authenticate_user!, :only => [:s, :subscription_sidebar] 

  def index
    @entries = Feed.find_by_url("http://stackoverflow.com/feeds").entries.limit(15) #feed by default
    @groups = all_fake_groups
  end

  def s
    @subs_groups = current_user.subscription_groups
    @subs_ungroup = current_user.subscriptions.where(:group_id => nil)
    @groups = @subs_groups
    @user = current_user
    render :template => 'home/index'
  end

  def subscription_sidebar
    @subs_groups = current_user.subscription_groups
    @subs_ungroup = current_user.subscriptions.where(:group_id => nil)
    respond_to do |format|
      format.js
    end
  end

  private
  def all_fake_groups
    [SubscriptionGroup.new(name: "TECH"), SubscriptionGroup.new(name: "GENERAL")]
  end

end
