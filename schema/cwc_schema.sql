CREATE DOMAIN dom_tag TEXT CHECK (
  LENGTH (VALUE) <= 255
);

CREATE TABLE Users (
  user_id SERIAL,
  username TEXT NOT NULL UNIQUE,
  email VARCHAR(90) NOT NULL UNIQUE,
  password TEXT NOT NULL,
  profile_picture_file TEXT,
  about_me TEXT,
  tags dom_tag,
  account_created TIMESTAMP NOT NULL,
  last_login TIMESTAMP NOT NULL,
  PRIMARY KEY (user_id),
  CONSTRAINT valid_username CHECK (
    LENGTH (username) > 0 AND
    LENGTH (username) <= 64 AND
    username ~* '^[a-z0-9_]+$'
  ),
  CONSTRAINT valid_email CHECK (
    email ~* '^[a-z0-9]+@uottawa[.]ca$'
  ),
  CONSTRAINT limit_about_length CHECK (
    LENGTH (about_me) <= 1000
  )
);

CREATE TABLE Submissions (
  submission_id SERIAL,
  title TEXT NOT NULL UNIQUE,
  date_created TIMESTAMP NOT NULL,
  date_modified TIMESTAMP NOT NULL,
  tags dom_tag,
  filehandle TEXT NOT NULL UNIQUE,
  user_id INTEGER NOT NULL,
  PRIMARY KEY (submission_id),
  FOREIGN KEY (user_id) REFERENCES Users(user_id)
    ON UPDATE CASCADE ON DELETE SET NULL,
  CONSTRAINT valid_title CHECK (
    LENGTH (title) > 0 AND
    LENGTH (title <= 255) AND
    title ~* '^[a-zàâçéèêëîïôûùüÿñæœ0-9\s\-_,\.;:()]+$'
  )
);

CREATE TABLE Comments (
  user_id INTEGER NOT NULL,
  submission_id INTEGER NOT NULL,
  date_created TIMESTAMP NOT NULL,
  date_modified TIMESTAMP NOT NULL,
  body TEXT NOT NULL,
  PRIMARY KEY (user_id, submission_id, date_created),
  FOREIGN KEY (user_id) REFERENCES Users(user_id)
    ON UPDATE CASCADE ON DELETE SET NULL,
  FOREIGN KEY (submission_id) REFERENCES Submissions(submission_id)
    ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT valid_comment CHECK (
    LENGTH (body) > 0 AND
    LENGTH (body) <= 500 AND
  )
);

CREATE TABLE Tags (
  tag_id SERIAL,
  body dom_tag,
  PRIMARY KEY (tag_id)
);

CREATE TABLE UserTags (
  user_id INTEGER NOT NULL,
  tag_id INTEGER NOT NULL,
  PRIMARY KEY (user_id, tag_id),
  FOREIGN KEY (user_id) REFERENCES Users(user_id)
    ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (tag_id) REFERENCES Tags(tag_id)
    ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE SubmissionTags (
  submission_id INTEGER NOT NULL,
  tag_id INTEGER NOT NULL,
  PRIMARY KEY (submission_id, tag_id),
  FOREIGN KEY (submission_id) REFERENCES Submissions(submission_id)
    ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (tag_id) REFERENCES Tags(tag_id)
    ON UPDATE CASCADE ON DELETE CASCADE
);
