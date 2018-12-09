defmodule Blog.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Blog.Accounts.User
  import Comeonin.Bcrypt, only: [hashpwsalt: 1]


  schema "users" do
    field :email, :string
    field :password_hash, :string
    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true
    field :is_admin, :boolean, default: false

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:email, :password, :password_confirmation])
    |> validate_required([:email, :password, :password_confirmation])
    |> validate_format(:email, ~r/@/)
    |> validate_length(:password, min: 8)
    |> validate_format(:password, ~r/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).*/, [message: "Must include at least one lowercase letter, one uppercase letter, and one digit¥n少なくとも1つの小文字、1つの大文字、および1つの数字を含める必要があります"])
    |> validate_confirmation(:password)
    |> unique_constraint(:email)
    |> put_password_hash
  end

  defp put_password_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: pass}}
        ->
          put_change(changeset, :password_hash, hashpwsalt(pass))
      _ ->
          changeset
    end
  end

  alias Blog.Repo
  alias Blog.User
  def find_and_confirm_password(email, password)do
    case Repo.get_by(User, email: email)do
      nil ->
        {:error, :not_found}
      user ->
        if Comeonin.Bcrypt.checkpw(password, user.password_hash)do
          {:ok, user}
        else
          {:error, :unauthorized}
        end
    end
  end

end
