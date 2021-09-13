Function TranslitText(RusText As String) As String
    Dim RusAlphabet As Variant 'массив из букв русского алфавита
    RusAlphabet = Array("а", "б", "в", "г", "д", "е", "ё", "ж", "з", "и", "й", "к", "л", "м", "н", "о", "п", "р", "с", "т", "у", "ф", "х", "ц", "ч", "ш", "щ", "ъ", "ы", "ь", "э", "ю", "я")
 
    Dim EngAlphabet As Variant 'массив из букв английского алфавита
    EngAlphabet = Array("a", "b", "v", "g", "d", "e", "e", "zh", "z", "i", "i", "k", "l", "m", "n", "o", "p", "r", "s", "t", "u", "f", "kh", "tc", "ch", "sh", "shch", "", "y", "", "e", "iu", "ia")
     
    Dim EngText As String, Letter As String, Flag As Boolean
             
    For i = 1 To Len(RusText) 'цикл по всем символам русского текста
        Letter = Mid(RusText, i, 1)
        Flag = 0
        For j = 0 To 32 'цикл по всем буквам русского алфавита
            If RusAlphabet(j) = LCase(Letter) Then 'если символ из текста совпал с буквой из русского алфавита...
                Flag = 1
                If RusAlphabet(j) = Letter Then 'проверка на регистр (верхний или нижний)
                    EngText = EngText & EngAlphabet(j) '... то добавляем соответствующую букву из английского алфавита
                    Exit For
                Else
                    EngText = EngText & UCase(EngAlphabet(j))
                    Exit For
                End If
            End If
        Next j
        If Flag = 0 Then EngText = EngText & Letter 'если символа из текста в алфавите нет (например, знаки препинания и т.п.), то добавляем символ без изменения
    Next i
    TranslitText = EngText
End Function
