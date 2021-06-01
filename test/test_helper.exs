ExUnit.start()
Ecto.Adapters.SQL.Sandbox.mode(GitExplorer.Repo, :manual)

Mox.defmock(GitExplorer.GitHub.ClientMock, for: GitExplorer.GitHub.Behaviour)
