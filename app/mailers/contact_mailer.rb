#encoding: utf-8
class ContactMailer < ActionMailer::Base
  default from: "feedback",
            to: "hunt.semen@gmail.com"

  headers = {'Return-Path' => 'hunt.semen@gmail.com'}

  def send_contact_email(feedback)
    @feedback = feedback

    mail(
      to: "hunt.semen@gmail.com",
      subject: "Отзыв с сайта FourStats",
      from: "<fourstats>",
      return_path: "hunt.semen@gmail.com",
      date: Time.now,
      content_type: "text/html"
    )
  end

end
