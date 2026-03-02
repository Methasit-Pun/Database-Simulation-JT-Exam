-- 1. Database Fundamentals

-- Data vs. Information: Data represents raw facts about an object, whereas Information is data that has been processed to be useful in decision-making.


-- Metadata: Descriptions of the properties or characteristics of data, including data types, field sizes, allowable values, and context.


-- Database Approach Advantages: Overcomes the disadvantages of traditional file processing (like data duplication and program-data dependence) by providing a centralized repository of shared data, managed by a Database Management System (DBMS). This leads to program-data independence and minimal data redundancy.
-- +1

-- 2. Entity-Relationship (ER) Modeling

-- Entity: A real-world object or concept with a distinguishable existence.


-- Strong Entity: Exists independently and has its own unique identifier.
-- +1


-- Weak Entity: Dependent on a strong entity and lacks a unique identifier of its own, possessing only a partial identifier.
-- +1


-- Associative Entity: A relationship with attributes that can act as an entity itself, often used to resolve Many-to-Many relationships.
-- +1


-- Attributes: Properties or characteristics of entities.


-- Composite Attribute: Can be broken down into component parts (e.g., an Address split into Street, City, State).


-- Multivalued Attribute: An entity instance can have more than one value for this attribute (e.g., multiple Skills).


-- Derived Attribute: Calculated from other attributes (e.g., calculating Age from Date of Birth).


-- Identifiers (Keys): An attribute or combination of attributes that uniquely identifies an individual entity instance. Identifiers must not change in value over the life of the instance and cannot be NULL.
-- +1


-- Relationships: Associations between two or more entities.


-- Degree: Indicates the number of entity types involved: Unary (degree 1), Binary (degree 2), or Ternary (degree 3).


-- Cardinality Constraints: Defines the minimum and maximum number of instances of one entity that can or must be associated with each instance of another entity. Relationships can be One-to-One (1:1), One-to-Many (1:M), or Many-to-Many (M:N).
-- +1

-- 3. Enhanced ER (EE-R) Modeling

-- Supertypes & Subtypes: A supertype is a generic entity type, while a subtype is a specialized subgrouping with distinct attributes.


-- Attribute Inheritance: Subtypes inherit all attributes and relationships of their supertype.


-- Generalization vs. Specialization: Generalization is a bottom-up process of defining a general entity from specialized ones, whereas Specialization is a top-down process of defining subtypes from a supertype.

-- Completeness Constraints:


-- Total Specialization (double line): An instance of a supertype MUST also be a member of at least one subtype.


-- Partial Specialization (single line): An instance of a supertype DOES NOT HAVE TO be a member of any subtype.

-- Disjointness Constraints:


-- Disjoint Rule: A supertype instance can be a member of only ONE of the subtypes.


-- Overlap Rule: A supertype instance can be a member of more than one subtype simultaneously.

-- 4. The Relational Model

-- Relations: A named, two-dimensional table of data containing rows (records or tuples) and columns (attributes or fields). For a table to be a relation, every attribute value must be atomic, every row must be unique, and the order of rows and columns is irrelevant.

-- Keys:


-- Primary Key (PK): A minimal set of attributes that uniquely identifies a row.


-- Foreign Key (FK): A set of attributes in one table that serves as a reference to the primary key of another table.

-- Integrity Constraints:


-- Domain Constraint: All values in a column must come from the same domain.


-- Entity Integrity Constraint: No attribute participating in the Primary Key may be NULL.


-- Referential Integrity Constraint: A Foreign Key value must either be NULL or match a Primary Key in another relation.

-- 5. Transforming ER to Relational Model (Mapping Rules)

-- Regular Entities: Create a new table for each entity and underline the Primary Key. For multivalued attributes, create an entirely new table.


-- Weak Entities: Create a separate table with a Foreign Key taken from the identifying strong entity. The Primary Key is a composite of the strong entity's PK and the weak entity's partial identifier.
-- +1

-- Binary Relationships:


-- 1:M: The Primary Key on the "one" side becomes a Foreign Key on the "many" side.


-- 1:1: The Primary Key on the mandatory side becomes a Foreign Key on the optional side.
-- +2


-- M:N: Create a new table where the Primary Keys of the two related entities act as a composite Primary Key.
-- +1


-- Supertype/Subtype: Create one relation for the supertype and one for each subtype. The Primary Key of the supertype relation also becomes the Primary Key of the subtype relations, establishing a 1:1 relationship.
-- +1

-- 6. Normalization & Functional Dependencies

-- Anomalies: Normalization decomposes tables with anomalies to produce well-structured relations that avoid data inconsistencies.


-- Insertion Anomaly: Adding new rows forces the user to create duplicate data.


-- Deletion Anomaly: Deleting a row causes the loss of other data representing completely different facts.


-- Modification Anomaly: Changing data in one row forces changes to other rows due to data duplication.


-- Functional Dependencies (FD): Occurs when the value of one attribute (the determinant) determines the value of another attribute.


-- Partial Dependency: A non-key attribute is dependent on only part of a composite primary key.


-- Transitive Dependency: A non-key attribute depends on another non-key attribute.

-- Normal Forms:


-- First Normal Form (1NF): Requires only atomic (simple, single-value) attributes and that a Primary Key has been identified.


-- Second Normal Form (2NF): The relation must be in 1NF AND have no partial functional dependencies.


-- Third Normal Form (3NF): The relation must be in 2NF AND have no transitive dependencies.


-- Boyce-Codd Normal Form (BCNF): An extension of 3NF; a relation is in BCNF if and only if every determinant is a candidate key.


-- Fourth Normal Form (4NF): Must be in 3NF and contain no multi-valued dependencies.