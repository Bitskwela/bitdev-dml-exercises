# Chapter 11 — Quiz Answer Key (with Questions)

Source: `quiz.md`

1. Q1 — Which platform is specifically optimized for deploying Next.js applications?

   - Answer: **B** — Vercel

2. Q2 — What is the recommended way to deploy a static site to Vercel for continuous updates?

   - Answer: **C** — Git repository connection

3. Q3 — What is a preview deployment in Vercel?

   - Answer: **A** — A unique URL for testing before production

4. Q4 — Vercel automatically creates a preview deployment for every pull request.

   - Answer: **True**

5. Q5 — Which file is used to configure Vercel project settings and deployment options?

   - Answer: **B** — `vercel.json`

6. Q6 — How do you securely add environment variables to your Vercel deployment?

   - Answer: **D** — In Vercel Environment Variables settings

7. Q7 — Environment variables set in a .env file on your local machine are automatically available in production.

   - Answer: **False**

8. Q8 — What rendering methods does Next.js support on Vercel?

   - Answer: **C** — Both SSR and SSG

9. Q9 — What is a key characteristic of serverless functions?

   - Answer: **B** — Execute only when called and billed per execution

10. Q10 — In Next.js, what directory contains API route handlers?

    - Answer: **A** — `api/`

11. Q11 — Edge functions in Vercel execute at locations closest to your users for lower latency.

    - Answer: **True**

12. Q12 — When does Edge Middleware execute in Vercel?

    - Answer: **D** — Before requests reach your application

13. Q13 — How often do Vercel Cron Jobs execute?

    - Answer: **C** — On a scheduled interval using cron expressions

14. Q14 — Images in Next.js using the Image component are automatically optimized and delivered in modern formats.

    - Answer: **False**

15. Q15 — What does Vercel Speed Insights measure?

    - Answer: **B** — All Core Web Vitals

16. Q16 — What is the good threshold for Largest Contentful Paint (LCP)?

    - Answer: **A** — < 2.5 seconds

17. Q17 — Vercel automatically provides SSL/TLS certificates for custom domains.

    - Answer: **True**

18. Q18 — Where should API keys and database passwords be stored for security?

    - Answer: **D** — In environment variables / secure vault (see quiz choices)

19. Q19 — When should automated tests run in a CI/CD pipeline?

    - Answer: **B**

20. Q20 — What is a rollback in Vercel?

    - Answer: **C** — Revert to a previous deployment (no rebuild)

21. Q21 — Vercel keeps all previous deployments available for instant rollback.

    - Answer: **True**

22. Q22 — Which are examples of security headers in Vercel configuration?

    - Answer: **A** — `X-Frame-Options, X-Content-Type-Options, CSP`

23. Q23 — What security features does Vercel's firewall provide?

    - Answer: **B** — Rate limiting (and other protections)

24. Q24 — Database connections should be made inside API routes without any optimization.

    - Answer: **False**

25. Q25 — What is a monorepo in the context of Vercel deployments?

    - Answer: **C** — Multiple projects in one repository

26. Q26 — What does deployment protection allow in Vercel team settings?

    - Answer: **A**

27. Q27 — Vercel Analytics provides insights into visitor traffic and geographic data.

    - Answer: **True**

28. Q28 — What CLI command deploys a project to production in Vercel?

    - Answer: **B** — `vercel` (or `vercel --prod` / `vercel publish`)

29. Q29 — Which configuration file defines custom build and output directories in Vercel?

    - Answer: **D** — `vercel.json`

30. Q30 — Preview deployments use the same domain as your production deployment.

    - Answer: **False**

31. Q31 — Vercel automatically deploys your application whenever you push to your **\_\_** repository.

    - Answer: **git**

32. Q32 — API routes in Next.js become **\_\_** functions when deployed to Vercel.

    - Answer: **serverless**

33. Q33 — **\_\_** functions in Vercel execute at locations near your users for reduced latency.

    - Answer: **edge**

34. Q34 — Speed Insights measures **\_\_** including LCP, INP, and CLS metrics.

    - Answer: **Core Web Vitals**

35. Q35 — API keys and secrets should be stored as **\_\_** variables in Vercel, not in source code.

    - Answer: **environment**

36. Q36 — Edge **\_\_** allows you to intercept and modify requests before they reach your application.

    - Answer: **middleware**

37. Q37 — A **\_\_** job in Vercel runs serverless functions on a scheduled interval.

    - Answer: **cron**

38. Q38 — Every pull request automatically gets a unique **\_\_** deployment URL for testing.

    - Answer: **preview**

39. Q39 — Vercel's **\_\_** (Web Application Firewall) protects against DDoS attacks and rate limits.

    - Answer: **WAF**

40. Q40 — A **\_\_** instantly reverts to a previous working deployment without rebuilding.
    - Answer: **rollback**

---

Would you like short explanations added to each item or a CSV export?
