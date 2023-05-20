return {
  git = {
    GitDiff = "GitDiff",
    GitCommit = "GitCommit",
    GitStash = "GitStash",
    GitPush = "GitPush",
    GitListCommits = "GitListCommits",
    GitListCurrentFileCommits = "GitListCurrentFileCommits",
    GitNextHunk = "GitNextHunk",
    GitPrevHunk = "GitPrevHunk",
    GitListBranches = "GitListBranches",
    GitChangedFiles = "GitChangedFiles",
    GitSomething = "GitSomething", -- TODO
  },
  explorer = {
    ExplorerLocateCurrentFile = "ExplorerLocateCurrentFile",
  },
  navigation = {
    OpenChangedFiles = "OpenChangedFiles",
    OpenRecentFiles = "OpenRecentFiles",
    LeapJump = "LeapJump",
    MaximiseBuffer = "MaximiseBuffer",

    TabNext = "TabNext",
    TabPrev = "TabPrev",
    TabClose = "TabClose",
    TabNew = "TabNew",

    BufferNext = "BufferNext",
    BufferPrev = "BufferPrev",
  },
  test = {
    TestRunNearest = "TestRunNearest",
    TestDebugNearest = "TestDebugNearest",
    TestOutputPanel = "TestOutputPanel",
    GoToTestFile = "GoToTestFile",
  },
  finder = {
    FindFiles = "FindFiles",
    FindCommands = "FindCommands",
    FindKeymappins = "FindKeymappins",
    FindInWholeProject = "FindInWholeProject",
    FzfLuaBuiltin = "FzfLuaBuiltin",
  },
  -- view = {
  -- TODO   

  -- },
  other = {
    CloseWindowOrBuffer = "CloseWindowOrBuffer",
    CopyBufferAbsolutePath = "CopyBufferAbsolutePath",
    CopyBufferDirectoryPath = "CopyBufferDirectoryPath",
  }
}
