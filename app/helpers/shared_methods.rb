module SharedMethods
    def require_admin
        @user = User.where(voting_key: params[:voting_key]).first
        if @user.blank?
          raise "Not authenticated"
        end
        unless User::ADMIN_EMAILS.include?(@user.email)
          raise "Not authenticated"
        end
      end
end