from flask import Flask, request, jsonify
import pandas as pd
import numpy as np

app = Flask(__name__)

# 데뷔일 유사도 계산 (최대 1점, 오래될수록 낮아짐)
def calculate_date_similarity(debut_date_1, debut_date_2):
    debut_date_1 = pd.to_datetime(debut_date_1, errors='coerce')
    debut_date_2 = pd.to_datetime(debut_date_2, errors='coerce')
    if pd.isna(debut_date_1) or pd.isna(debut_date_2):  # 날짜가 NaT면 유사도 0
        return 0
    return np.exp(-abs((debut_date_1 - debut_date_2).days) / 1825)  # 5년(=1825일) 기준 정규화

# 성별 유사도 (같으면 1, 다르면 0)
def calculate_gender_similarity(gender_1, gender_2):
    return 1 if gender_1.lower() == gender_2.lower() else 0

# 소속사 유사도 (같으면 1, 다르면 0)
def calculate_company_similarity(company_1, company_2):
    return 1 if company_1.lower() == company_2.lower() else 0

# 아티스트 추천
def recommend_artists(artist_data, user_artist_name):
    # 한글 ↔ 영어 변환 맵핑 (대소문자 구분 X)
    name_mapping = {}
    for artist in artist_data:
        if artist["korean_name"]:  # 한글 이름이 존재하면
            name_mapping[artist["korean_name"].lower()] = artist["name"]
        if artist["name"]:  # 영어 이름이 존재하면
            name_mapping[artist["name"].lower()] = artist["korean_name"]

    # 입력값을 소문자로 변환하여 검색
    user_artist_name = user_artist_name.lower()

    # 영어 또는 한글 입력값을 기반으로 검색
    if user_artist_name in name_mapping:
        user_artist_name = name_mapping[user_artist_name]  # 변환된 이름 사용

    # 사용자 아티스트 찾기 (대소문자 구분 없이 검색)
    user_artist = next((artist for artist in artist_data if artist["name"].lower() == user_artist_name.lower() or artist["korean_name"].lower() == user_artist_name.lower()), None)
    if not user_artist:
        return {"error": "입력하신 아티스트는 목록에 없습니다. 그룹명이 정확한지 확인해주세요."}

    # 유사도 계산
    similarity_scores = []
    for artist in artist_data:
        if artist["name"].lower() == user_artist["name"].lower():
            continue  # 자기 자신 제외

        # 개별 유사도 계산
        gender_score = calculate_gender_similarity(user_artist["gender"], artist["gender"])  # 1점 or 0점
        company_score = calculate_company_similarity(user_artist["company"], artist["company"])  # 1점 or 0점
        date_score = calculate_date_similarity(user_artist["debut"], artist["debut"])  # 0~1점

        # 최종 유사도 계산 (가중치 적용)
        final_score = (gender_score * 0.5) + (company_score * 0.3) + (date_score * 0.2)

        similarity_scores.append({
            "name": artist["name"],
            "korean_name": artist["korean_name"],
            "score": final_score,
            "debut": artist["debut"],
            "gender": artist["gender"],
            "company": artist["company"],
            "imagePath": artist["imagePath"]  # 이미지 경로 추가
        })

    # 점수가 높은 순으로 정렬 후 상위 5개만 선택
    similarity_scores = sorted(similarity_scores, key=lambda x: x["score"], reverse=True)[:10]

    return {
        "searched_artist": user_artist,
        "recommendations": similarity_scores
    }

@app.route('/recommend', methods=['POST'])
def recommend():
    # 요청에서 아티스트 이름을 가져옴
    user_artist_name = request.json.get('artist_name')
    if not user_artist_name:
        return jsonify({"error": "Artist name is required"}), 400

    # CSV에서 아티스트 데이터 로드
    df = pd.read_csv("artist_data2.csv", encoding="cp949")
    print(df.columns) 

    # NaN 값이 있으면 빈 문자열("")로 변환
    df["korean_name"] = df["korean_name"].fillna("")
    df["Debut"] = df["Debut"].fillna("")

    # 아티스트 데이터를 리스트로 변환
    artist_data = []
    for _, row in df.iterrows():
        print(f"Image Path: {row['imagePath']}")
        artist_data.append({
            "name": row["name"],  # 영어 이름
            "korean_name": row["korean_name"],  # 한글 이름
            "debut": row["Debut"],
            "gender": row["Gender"],
            "company": row["Company"],
            "imagePath": row["imagePath"]  # 이미지 경로 추가
        })
       

    # 아티스트 추천 실행
    result = recommend_artists(artist_data, user_artist_name)

    # 추천 결과 반환
    return jsonify(result)


if __name__ == '__main__':
    app.run(debug=True,port=5001)   
