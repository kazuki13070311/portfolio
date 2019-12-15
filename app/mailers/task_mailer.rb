class TaskMailer < ApplicationMailer
    default from: 'kazu_0311@iclud.com'

    def creation_email(task)
       @task = task
       mail(
           subject: 'フレンド募集完了メール',
           to: 'kazuki13070311@gmail.com',
           from: 'kazu_0311@icloud.com'
       )
    end
end
