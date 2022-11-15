package com.example.aop;

import java.util.Arrays;
import java.util.List;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.reflect.MethodSignature;
import org.springframework.stereotype.Component;

@Aspect // 주변부 로직을 가진 어드바이스 클래스
@Component // 스프링 빈으로 등록
public class LogAdvice {

	// AOP 애노테이션 값으로 포인트컷 표현식으로 타겟 오브젝트의 포인트컷을 표현함
	@Before("execution( * com.example.service.MemberService.*(..) )")
	public void logBefore() {
		System.out.println("===================== logBefore() ===========================");
	}

	// @Around 사용 시에는 반드시 매개변수를 ProceedingJoinPoint 타입을 선언하고
	// 리턴타입은 Object 가 되야 함에 주의!
	@Around("execution( * com.example.service.MemberService.*(..) )")
	public Object logTime(ProceedingJoinPoint joinPoint) throws Throwable {
		System.out.println("===================== logTime() ===========================");

		MethodSignature methodSignature = (MethodSignature) joinPoint.getSignature();
		String methodName = methodSignature.getName(); // 타깃 메소드의 이름

		Object[] args = joinPoint.getArgs(); // 타깃 메소드의 매개변수 정보
		List<Object> argsList = Arrays.asList(args);

		System.out.println("메소드명: " + methodName + ", 매개변수: " + argsList);

		long beginTime = System.currentTimeMillis();

		Object result = joinPoint.proceed(); // 실제 타깃 메소드를 호출함!
		System.out.println("@Around result : " + result);

		long endTime = System.currentTimeMillis();

		long diffTime = endTime - beginTime;
		System.out.println(methodName + " 메소드의 실행시간: " + diffTime + "ms");

		// proceed 메소드가 리턴한 결과는 리턴을 해줘야 함
		return result;
	} // logTime

}
