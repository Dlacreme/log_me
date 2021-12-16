%LogMe.Schemas.Users{}
|> LogMe.Schemas.Users.changeset_register(%{
  email: "admin@logme.com",
  password: "toto4242",
  role_id: "admin"
})
|> LogMe.Repo.insert()
