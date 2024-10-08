B4J=true
Group=Modules
ModulesStructureVersion=1
Type=Class
Version=10
@EndOfDesignText@
' Description	: Minimal List of Maps
' Version		: 1.04
' 2024-10-08 Added Reverse, FindByKey, SortByKey, Snippet 08
' 2024-04-24 Update Snippets, removed #plural tag
' 2023-12-09 Added CopyList
' 2023-10-24 Added Exclude, ExcludeAll and ExcludeAny subs, remove mMap
' 2023-10-18 Packaged as B4Xlib with Controller code snippet
' 2023-09-19 Added FindAnyLike sub
' 2023-08-16 Updated FindFirst and FindAll subs
' 2023-07-31 Added Count, Find, FindFirst and FindAll subs
' 2023-06-09 Added code sample when hover Sub Initialize
Sub Class_Globals
	Private mList As List
	Private mFirst As Map
	Private mLast As Map
End Sub

Public Sub Initialize
	mList.Initialize
	mFirst.Initialize
	mLast.Initialize
End Sub

Public Sub setList (L1 As List)
	mList = L1
	If mList.Size > 0 Then
		mFirst = mList.Get(0)
		mLast = mList.Get(mList.Size - 1)
	End If
End Sub

Public Sub getList As List
	Return mList
End Sub

' Get First item
Public Sub getFirst As Map
	Return mFirst
End Sub

' Get Last item
Public Sub getLast As Map
	Return mLast
End Sub

' Add new item
Public Sub Add (M As Map)
	Dim id As Long
	If mList.Size = 0 Then
		id = 1
		mFirst = M
	Else
		id = mList.Get(mList.Size - 1).As(Map).Get("id") + 1
	End If
	M.Put("id", id)
	mList.Add(M)
	mLast = M
End Sub

' Make a copy of the List
Public Sub CopyList As Object
	Dim ser As B4XSerializator
	Return ser.ConvertBytesToObject(ser.ConvertObjectToBytes(mList))
End Sub

' Count items where value of a key is equals to id
Public Sub Count (key As String, id As Long) As Int
	Dim num As Int
	For Each M As Map In mList
		If M.ContainsKey(key) And M.Get(key) <> "" Then
			If id = M.Get(key) Then
				num = num + 1
			End If
		End If
	Next
	Return num
End Sub

' Remove item by index
Public Sub Remove (index As Long)
	If mList.Size > 0 Then
		mList.RemoveAt(index)
	End If
	If mList.Size = 0 Then
		mFirst.Clear
		mLast.Clear
	Else
		mFirst = mList.Get(0)
		mLast = mList.Get(mList.Size - 1)
	End If
End Sub

' Remove item by passing a Map object
Public Sub Remove2 (M As Map)
	If mList.Size > 0 Then
		For i = 0 To mList.Size - 1
			Dim O As Map = mList.Get(i)
			If O.Get("id") = M.Get("id") Then
				'LogDebug("Found")
				mList.RemoveAt(i)
				Exit
			End If
		Next
	End If

	If mList.Size = 0 Then
		mFirst.Clear
		mLast.Clear
	Else
		mFirst = mList.Get(0)
		mLast = mList.Get(mList.Size - 1)
	End If
End Sub

' Remove key in Map by index
Public Sub RemoveKey (key As String, index As Long)
	Dim M As Map = mList.Get(index)
	If M.ContainsKey(key) Then
		M.Remove(key)
	End If
End Sub

' Remove key in Map by passing a Map object
Public Sub RemoveKey2 (key As String, M As Map)
	If M.ContainsKey(key) Then
		M.Remove(key)
	End If
End Sub

' Get index of item by Map object
Public Sub IndexFromMap (M As Map) As Long
	Dim Index As Long
	For Each O As Map In mList
		If O.Get("id") = M.Get("id") Then
			'LogDebug("Found")
			Return Index
		End If
		Index = Index + 1
	Next
	Return -1
End Sub

' Get index of item by id key
Public Sub IndexFromId (id As Long) As Long
	Dim Index As Long
	For Each O As Map In mList
		If id = O.Get("id") Then
			'LogDebug("Found")
			Return Index
		End If
		Index = Index + 1
	Next
	Return -1
End Sub

' Find first item based on id key
Public Sub Find (id As Long) As Map
	For Each M As Map In mList
		If id = M.Get("id") Then
			Return M
		End If
	Next
	Return CreateMap()
End Sub

' Find first item where key and value list matched
Public Sub FindFirst (keys As List, values As List) As Map
	Dim index As Int = -1
	For i = 0 To mList.Size - 1
		Dim matched As Boolean
		Dim temp As Map = mList.Get(i)
		For k = 0 To keys.Size - 1
			If temp.ContainsKey(keys.Get(k)) = False Then Continue
			If temp.Get(keys.Get(k)).As(String).ToLowerCase = values.Get(k).As(String).ToLowerCase Then
				matched = True
				index = i
			Else
				matched = False
				Exit
			End If
		Next
		If matched Then Return mList.Get(index)
	Next
	Return CreateMap()
End Sub

' Find more than one item as list where all keys and values must matched
Public Sub FindAll (keys As List, values As List) As List
	'Dim index As Int = -1
	Dim result As List
	result.Initialize
	For i = 0 To mList.Size - 1
		Dim matched As Boolean
		Dim temp As Map = mList.Get(i)
		For k = 0 To keys.Size - 1
			If temp.Get(keys.Get(k)).As(String).ToLowerCase = values.Get(k).As(String).ToLowerCase Then
				matched = True
			Else
				matched = False
				Exit
			End If
		Next
		If matched Then result.Add(mList.Get(i))
	Next
	Return result
End Sub

' Find more than one item as list where at least one key and value matched
Public Sub FindAnyLike (keys As List, values As List) As List
	Dim result As List
	result.Initialize
	For i = 0 To mList.Size - 1
		Dim matched As Boolean
		Dim temp As Map = mList.Get(i)
		For k = 0 To keys.Size - 1
			If temp.Get(keys.Get(k)).As(String).ToLowerCase.Contains(values.Get(k).As(String).ToLowerCase) Then
				matched = True
			End If
		Next
		If matched Then result.Add(mList.Get(i))
	Next
	Return result
End Sub

' Exclude item based on id key
Public Sub Exclude (id As Long) As List
	For i = 0 To mList.Size - 1
		Dim temp As Map = mList.Get(i)
		If id = temp.Get("id") Then
			mList.RemoveAt(i)
			Exit
		End If
	Next
	Return mList
End Sub

' Exclude given all keys and values are matched from list
Public Sub ExcludeAll (keys As List, values As List) As List
	For i = 0 To mList.Size - 1
		Dim matched As Boolean = True
		Dim temp As Map = mList.Get(i)
		For k = 0 To keys.Size - 1
			If temp.Get(keys.Get(k)).As(String).ToLowerCase <> values.Get(k).As(String).ToLowerCase Then
				' At least a key is not matched
				matched = False
				Exit
			End If
		Next
		If matched Then mList.RemoveAt(i)
	Next
	Return mList
End Sub

' Exclude given any keys and values are matched from list
Public Sub ExcludeAny (keys As List, values As List) As List
	For i = 0 To mList.Size - 1
		Dim matched As Boolean = False
		Dim temp As Map = mList.Get(i)
		For k = 0 To keys.Size - 1
			If temp.Get(keys.Get(k)).As(String).ToLowerCase = values.Get(k).As(String).ToLowerCase Then
				' At least a key is matched
				matched = True
				Exit
			End If
		Next
		If matched Then mList.RemoveAt(i)
	Next
	Return mList
End Sub

Public Sub Reverse
	Dim sList As List
	sList.Initialize
	For i = mList.Size - 1 To 0 Step - 1
		sList.Add(mList.Get(i))
	Next
	setList(sList)
End Sub

' Find first item based on any key
Public Sub FindByKey (key As String, value As Object) As Map
	For Each M As Map In mList
		If value = M.Get(key) Then
			Return M
		End If
	Next
	Return CreateMap()
End Sub

Public Sub SortByKey (key As String, ascending As Boolean)
	Dim sorted As List
	sorted.Initialize
	For i = 0 To mList.Size - 1
		sorted.Add(mList.Get(i).As(Map).Get(key))
	Next
	sorted.Sort(ascending)
	Dim sList As List
	sList.Initialize
	For i = 0 To sorted.Size - 1
		sList.Add(FindByKey(key, sorted.Get(i)))
	Next
	setList(sList)
End Sub