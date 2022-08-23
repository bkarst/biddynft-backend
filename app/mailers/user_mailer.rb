class UserMailer < ApplicationMailer
    
    default from: email_address_with_name('admin@blackholeonjuno.com', 'Black Hole Team')

    def verification
        @user = User.find(params[:user_id])
        @url = "http://www.blackholeonjuno.com/loginwithemail?" + "voting_key=" + @user.voting_key
        mail(to: @user.email, subject: 'Please Verify Your Blackhole email')
    end

end
