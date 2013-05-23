module WorksHelper

  def show_claim(wc)
    if wc.user == self.current_user
      wc.mr_share
   elsif self.current_user.admin?
      wc.mr_share if wc.user == User.find(params[:id])
    end
  end

  def build_claim(f)
    f.object.work_claims.build
  end
end
