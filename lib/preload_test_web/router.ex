defmodule PreloadTestWeb.Router do
  use PreloadTestWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", PreloadTestWeb do
    pipe_through :api
  end
end
