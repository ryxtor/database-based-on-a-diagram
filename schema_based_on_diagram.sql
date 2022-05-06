CREATE DATABASE clinic;

CREATE TABLE patients (
  id INT GENERATED ALWAYS AS IDENTITY,
  name VARCHAR(100) NOT NULL,
  date_of_birth DATE NOT NULL,
  PRIMARY KEY(id)
);

CREATE TABLE medical_histories (
  id INT GENERATED ALWAYS AS IDENTITY,
  admitted_at TIMESTAMP NOT NULL,
  patient_id INT NOT NULL,
  status VARCHAR(100) NOT NULL,
  PRIMARY KEY(id),
  CONSTRAINT constraint_patient
  FOREIGN KEY(patient_id) REFERENCES patients(id)
);

CREATE TABLE treatments (
  id INT GENERATED ALWAYS AS IDENTITY,
  type VARCHAR(100) NOT NULL,
  name VARCHAR(100) NOT NULL,
  PRIMARY KEY(id)
);

CREATE TABLE mh_join_treatments (
  id INT GENERATED ALWAYS AS IDENTITY,
  medical_histories_id INT,
  treatments_id INT,
  PRIMARY KEY(id),
  FOREIGN KEY(medical_histories_id) REFERENCES medical_histories(id),
  FOREIGN KEY(treatments_id) REFERENCES treatments(id)
);

CREATE TABLE invoices (
  id INT GENERATED ALWAYS AS IDENTITY,
  total_amount DECIMAL NOT NULL,
  generated_at TIMESTAMP NOT NULL,
  payed_at TIMESTAMP NOT NULL,
  medical_history_id INT NOT NULL,
  PRIMARY KEY(id),
  FOREIGN KEY(medical_history_id) REFERENCES medical_histories(id)
);

CREATE TABLE invoice_items (
  id INT GENERATED ALWAYS AS IDENTITY,
  unit_price DECIMAL NOT NULL,
  quantity INT NOT NULL,
  total_price DECIMAL NOT NULL,
  invoice_id INT NOT NULL,
  treatment_id INT NOT NULL,
  PRIMARY KEY(id),
  FOREIGN KEY(invoice_id) REFERENCES invoices(id),
  FOREIGN KEY(treatment_id) REFERENCES treatments(id)
);

CREATE INDEX mh_patient_id_idx ON medical_histories(patient_id);
CREATE INDEX mhjt_medical_histories_id_idx ON mh_join_treatments(medical_histories_id);
CREATE INDEX mhjt_treatments_id_idx ON mh_join_treatments(treatments_id);
CREATE INDEX i_medical_history_id_idx ON invoices(medical_history_id);
CREATE INDEX ii_invoice_id_idx ON invoice_items(invoice_id);
CREATE INDEX ii_treatment_id_idx ON invoice_items(treatment_id);
