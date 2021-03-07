defmodule ContaiWeb.Router do
  use ContaiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/operations", ContaiWeb do
    pipe_through :api
    get "/", OperationController, :index
    post "/sum", OperationController, :sum
    post "/sub", OperationController, :sub
    post "/div", OperationController, :div
    post "/mul", OperationController, :mul
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).

  def swagger_info do
    %{
      schemes: ["http"],
      info: %{
        version: "1.0",
        title: "APICalculator",
        description: "API Documentation for APICalculator v1",
        termsOfService: "Open for public",
        contact: %{
          name: "Rodrigo Otsuka",
          email: "akio2631@gmail.com"
        }
      },
      securityDefinitions: %{
        Bearer: %{
          type: "apiKey",
          name: "Authorization",
          description:
          "API Token must be provided via `Authorization: Bearer ` header",
      in: "header"
        }
      },
      consumes: ["application/json"],
      produces: ["application/json"],
      tags: [
        %{name: "Operations", description: "Operations (List, sum, sub, div, mul)"},
      ]
    }
  end

  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through [:fetch_session, :protect_from_forgery]
      live_dashboard "/dashboard", metrics: ContaiWeb.Telemetry
    end
  end
end
