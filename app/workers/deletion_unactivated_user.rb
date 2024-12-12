class DeletionUnactivatedUser < BaseWorker
  queue_as :default

  def perform(user_id)
    user = User.find_by(id: user_id)

    return if user.blank?

    user.destroy
  end
end
