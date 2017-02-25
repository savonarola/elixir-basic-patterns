defmodule User do
  defstruct [:login, :password, :name]
  @type t :: %User{}
end

defmodule ValidateUserGood do

  @type validate_error :: :invalid_login | :invalid_password | :invalid_name

  @spec validate(User.t) :: :ok | {:error, validate_error}
  def validate(%User{} = user) do
    with :ok <- validate_login(user),
      :ok <- validate_password(user),
      :ok <- validate_name(user)
    do
      :ok
    else
      error -> {:error, error}
    end
  end

  @login_re ~r/\A\w{5,20}\z/
  @min_password_length 8
  @name_re ~r/\A[\w ]+\z/

  defp validate_login(%User{login: login}) do
    if Regex.match?(@login_re, login), do: :ok, else: :invalid_login
  end

  defp validate_password(%User{password: password}) do
    if String.length(password) >= @min_password_length, do: :ok, else: :invalid_password
  end

  defp validate_name(%User{name: name}) do
    if Regex.match?(@name_re, name), do: :ok, else: :invalid_name
  end
end

defmodule ValidateUserBad do

  defmodule LoginError do
    defexception message: "invalig login"
  end

  defmodule PasswordError do
    defexception message: "invalig password"
  end

  defmodule NameError do
    defexception message: "invalig name"
  end

  @spec validate!(User.t) :: :ok | no_return # WOW, such useful, very functional
  def validate!(%User{} = user) do
    validate_login!(user)
    validate_password!(user)
    validate_name!(user)
    :ok
  end

  @login_re ~r/\A\w{5,20}\z/
  @min_password_length 8
  @name_re ~r/\A[\w ]+\z/

  defp validate_login!(%User{login: login}) do
    unless Regex.match?(@login_re, login), do: raise LoginError
  end

  defp validate_password!(%User{password: password}) do
    unless String.length(password) >= @min_password_length, do: raise PasswordError
  end

  defp validate_name!(%User{name: name}) do
    unless Regex.match?(@name_re, name), do: raise NameError
  end

end
