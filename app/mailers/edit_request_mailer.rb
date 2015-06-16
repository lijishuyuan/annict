class EditRequestMailer < ActionMailer::Base
  default from: 'Annict <no-reply@annict.com>'

  def comment_notification(db_activity_id)
    db_activity = DbActivity.find(db_activity_id)

    @edit_request = db_activity.recipient
    @edit_request_comment = db_activity.trackable
    @user = db_activity.user
    @name = @user.profile.name

    subject = "【Annict DB】#{@name}さんが編集リクエストにコメントしました"

    @edit_request.participants.where.not(user: db_activity.user).each do |p|
      mail(to: p.user.email, subject: subject)
    end
  end
end