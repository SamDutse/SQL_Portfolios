SELECT 
	react.F1,
	react.[Content ID],
	react.Type,
	Datetime,
	cont.Type,
	cont.Category,
	react_t.Type,
	react_t.Sentiment,
	react_t.Score
FROM
	samdutse.dbo.Reaction$ AS react
INNER JOIN
	samdutse.dbo.Content$ AS cont
		ON react.[Content ID] = cont.[Content ID]
INNER JOIN
	samdutse.dbo.Reaction_Type$ AS react_t
		ON react.Type = react_t.Type