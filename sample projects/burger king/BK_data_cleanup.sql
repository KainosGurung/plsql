CREATE OR REPLACE PACKAGE bk_data_cleanup
AS
  PROCEDURE clean_bk_locations;
END;
/
CREATE OR REPLACE PACKAGE BODY bk_data_cleanup
AS
 
  PROCEDURE clean_bk_locations
  IS
    CURSOR bk_loc
    IS
      SELECT longitude, latitude, NAME, address FROM burger_king_locations;
    longitude burger_king_locations.longitude%TYPE;
    latitude burger_king_locations.latitude%TYPE;
    name burger_king_locations.name%TYPE;
    address burger_king_locations.address%TYPE;
    street_address bk_locations_clean.street_address%TYPE;
    city bk_locations_clean.city%TYPE;
    state bk_locations_clean.state%TYPE;
    zip bk_locations_clean.zip%TYPE := NULL;
    phone bk_locations_clean.phone%TYPE;
    err_msg bk_locations_unresolved.problem_desc%TYPE;
    l_vc_arr2 apex_application_global.vc_arr2;
    flag    NUMBER;
    counter NUMBER := 0;
  BEGIN
    OPEN bk_loc;
    LOOP
      flag    := 0;
      counter := counter + 1;
      err_msg := NULL;
      FETCH bk_loc INTO longitude, latitude, name, address;
      EXIT
    WHEN bk_loc%notfound;
      l_vc_arr2           := apex_util.string_to_table(address, ',');
      IF (l_vc_arr2.count != 4) THEN
        err_msg           := err_msg || 'Address field is malformed; Invalid number of tokens in the address field';
        INSERT
        INTO bk_locations_unresolved VALUES
          (
            longitude,
            latitude,
            NAME,
            address,
            err_msg
          );
        CONTINUE;
      END IF;
      street_address     := rtrim(ltrim(l_vc_arr2(1)));
      city               := rtrim(ltrim(l_vc_arr2(2)));
      state              := rtrim(ltrim(l_vc_arr2(3)));
      phone              := rtrim(ltrim(l_vc_arr2(4)));
      IF (street_address IS NULL) THEN
        err_msg          := err_msg || 'Missing street address; ';
        flag             := 1;
      END IF;
      IF (city  IS NULL) THEN
        err_msg := err_msg || 'Missing city; ';
        flag    := 1;
      END IF;
      IF (state IS NULL) THEN
        err_msg := err_msg || 'Missing state; ';
        flag    := 1;
      END IF;
      IF (phone IS NULL) THEN
        err_msg := err_msg || 'Missing phone; ';
        flag    := 1;
      END IF;
      IF (flag = 0) THEN -- no missing values
        INSERT
        INTO bk_locations_clean
          (
            longitude,
            latitude,
            street_address,
            city,
            state,
            zip,
            phone
          )
          VALUES
          (
            longitude,
            latitude,
            street_address,
            city,
            state,
            zip,
            phone
          );
      ELSE
        INSERT
        INTO bk_locations_unresolved VALUES
          (
            longitude,
            latitude,
            name,
            address,
            err_msg
          );
      END IF;
    END LOOP;
    CLOSE bk_loc;
  END;
END bk_data_cleanup;
/