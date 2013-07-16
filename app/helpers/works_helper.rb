module WorksHelper

  def show_claim(wc)
    if wc.user == self.current_user
      wc.mr_share.to_s + "%"
   elsif self.current_user.admin?
      (wc.mr_share.to_s + "%") if wc.user == @user
    end
  end

  def status(work)
    if work.pending?
      content_tag(:div, " (pending)", class: "work-status") + " " + tooltip_for(:pending)
    end
  end
end
