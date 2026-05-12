# Converting Messy Data to Clean Data

Let's do what Dan did that night: take Tita Malou's messy, unstructured notebook entries and convert them into a clean, structured CSV file using Python.

This is a real-world data engineering task. Data scientists spend a huge chunk of their time on this — cleaning and structuring data so models can use it.

---

## Task 1: Structure the Unstructured

Open `act_1.py`. You'll find Tita Malou's messy notebook entries as Python strings. Your job:

1. **Convert each entry to a dict** with fields: `date`, `item`, `quantity`, `revenue`, `payment_method`.
2. **Write to CSV** using `csv.DictWriter`.
3. **Read back and display** as a formatted table.
4. **Analyze**: total revenue, cash vs GCash split, record count.

### Example Conversion

Before (unstructured):
```
"March 1 - Aling Rosa bought Adobo and Rice, paid 70 pesos, cash"
```

After (structured):
```python
{
    "date": "2026-03-01",
    "item": "Adobo + Rice",
    "quantity": 1,
    "revenue": 70,
    "payment_method": "cash"
}
```

### Sample Output

```
Structured Data (readable table):
---------------------------------------------------------------------------
Date         Item                             Qty  Revenue    Payment
---------------------------------------------------------------------------
2026-03-01   Adobo + Rice                       1  P    70       cash
2026-03-01   Sinigang + Rice                    1  P    85      GCash
...

📊 Analysis:
   Total records:   8
   Total revenue:   P1,285
   Cash revenue:    P245
   GCash revenue:   P310
```

---

## Task 2: Reflect

After structuring the data, answer:

1. What information did you LOSE when converting to structured form? (e.g., "It rained today")
2. What new analyses become POSSIBLE with structured data?
3. Which payment method is more popular in the sample?

---

## Challenge: Data Type Classifier

Build a function that classifies data sources as Structured, Semi-Structured, or Unstructured.

### Data Types to Classify

- Handwritten notebook
- GCash CSV export
- Facebook menu board photo
- JSON from a delivery API
- Voice message on Messenger
- Excel sales report
- Customer review tweet
- HTML menu page
- CCTV footage

### Bonus: Expand the Dataset

Add 5 more messy notebook entries, convert them to structured format, and append to your CSV. Then re-run the analysis.

---

## What You've Learned

- Reading unstructured text and transforming it into structured records
- Using `csv.DictWriter` to write CSV files
- The dictionary pattern for structured records
- Why data cleaning is 80% of a data scientist's work

Next up: **Intro to Python for AI** — Dan levels up his Python skills.
