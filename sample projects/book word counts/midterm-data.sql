
insert into m_books values ( 1, 'The Haunters and the Haunted', '', 'Rhys, Ernest', '1-58734-109-3', 1921, 'http://bartleby.com/166/' );
insert into m_books values ( 2, 'The Sleeping Beauty and other Fairy Tales', 'Quiller-Couch, Arthur Thomas, Sir', '', '', 1910, 'http://bartleby.com/76/' );
insert into m_books values ( 3, 'Eleonora', 'Poe, Edgar Allan', '', '', 1917, 'http://bartleby.com/310/3/1.html' );
insert into m_books values ( 4, 'The Fall of the House of Usher', 'Poe, Edgar Allan', '', '', 1917, 'http://bartleby.com/310/3/2.html' );
insert into m_books values ( 5, 'The Purloined Letter', 'Poe, Edgar Allan', '', '', 1917, 'http://bartleby.com/310/3/3.html' );

-- the totalwords count may be "bloated" since it was determined
--  by counting words from http://bartleby.com/166/index.html,
--   which include navigational sections, advertisements, etc.
insert into m_counts values ( 1, 143139, 394 );
insert into m_counts values ( 2, 26792, 228 );
insert into m_counts values ( 3, 2966, 0 );
insert into m_counts values ( 4, 7403, 0 );
insert into m_counts values ( 5, 7263, 0 );
