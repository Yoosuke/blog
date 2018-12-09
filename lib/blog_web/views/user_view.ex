defmodule BlogWeb.UserView do
  use BlogWeb, :view

  def render("jwt.json", %{jwt: jwt}) do
    %{jwt: jwt}
  end

end
