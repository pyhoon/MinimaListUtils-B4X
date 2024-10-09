# MinimaListUtils-B4X
Version: 1.05 \
A utility class to manipulate a simple List of Map to do basic CRUD.

It depends on **KeyValueStore** library.\
This b4xlib replaces the class from MinimaList published in B4J code snippet.

Code snippets also included for creating RESTful API subs for MinimaList Controller when developing with Web API Template 2.04+.

---

**Properties**
- First As Map (read)
- Last As Map (read)
- List (read/write)

**Methods**
- Add (M As Map)
- CopyList As List
- CopyObject (xo As Object) As Object
- Count (key As String, id As Long) As Int
- Exclude (id As Long) As List
- ExcludeAll (keys As List, values As List) As List
- ExcludeAny (keys As List, values As List) As List
- Find (id As Long) As Map
- FindAll (keys As List, values As List) As List
- FindAnyLike (keys As List, values As List) As List
- FindByKey (key As String, value As Object)
- FindFirst (keys As List, values As List) As Map
- IndexFromId (id As Long) As Long
- IndexFromMap (M As Map) As Long
- Remove (index As Long)
- Remove2 (M As Map)
- RemoveKey (key As String, index As Long)
- RemoveKey2 (key As String, M As Map)
- Reverse
- SortByKey (key As String, ascending As Boolean)

**What's New**
- Version 1.05
  - Fix bug in SortByKey
  - Added CopyObject
  - Update CopyList
- Version 1.04
  - Added Reverse, FindByKey, SortByKey
  - Updated Snippet 08
- Version 1.03
  - Update Snippets, removed #plural tag
- Version 1.02
  - Added CopyList sub
- Version 1.01
  - Add KeyValueStore dependency to manifest file
