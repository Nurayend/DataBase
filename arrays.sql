SELECT array_append(ARRAY[1, 2], 3);

SELECT array_cat(ARRAY['Adam', 'Mina'], ARRAY['Nuray', 'Farida']);

SELECT array_ndims(ARRAY[1, 3]);

SELECT array_fill(7, ARRAY[3], ARRAY[3]);

SELECT array_length(ARRAY[1, 2], 1);

SELECT array_lower('[0:3]={1,2,3,4}'::int[], 1);

SELECT array_position(ARRAY[1, 2, 3, 4], 2);

SELECT array_positions(ARRAY[1, 2, 1, 3, 1], 1);

SELECT array_prepend(1, ARRAY[2, 3, 4]);

SELECT array_remove(ARRAY[1, 2, 2, 2], 2);

SELECT array_replace(ARRAY['I', 'am', 'happy'], 'happy', 'tired');