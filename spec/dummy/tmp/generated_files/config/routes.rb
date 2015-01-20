TestApp::Application.routes.draw do
  mount Waitlist::Engine => "/waitlist", as: "waitlist"
end
